import { useEffect, useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { StatCard } from '@/components/ui/StatCard';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { mockApi } from '@/lib/mockApi';
import type { AdminAlert } from '@/lib/types';
import { getApiBaseUrl } from '@/lib/api';

export function AdminDashboardPage() {
  const { data: kpis = [], isLoading } = useQuery({
    queryKey: ['admin', 'kpis'],
    queryFn: () => mockApi.getAdminKpis(),
  });
  const { data: initialAlerts = [] } = useQuery({
    queryKey: ['admin', 'alerts'],
    queryFn: () => mockApi.getAdminAlerts(),
  });
  const [alerts, setAlerts] = useState<AdminAlert[]>([]);

  useEffect(() => {
    setAlerts(initialAlerts);
  }, [initialAlerts]);

  useEffect(() => {
    const base = getApiBaseUrl();
    const es = new EventSource(`${base}/admin/alerts/stream`);

    es.onmessage = (ev) => {
      try {
        const alert = JSON.parse(ev.data) as AdminAlert;
        setAlerts((prev) => [alert, ...prev].slice(0, 20));
      } catch {
        /* mock stream may be unavailable */
      }
    };

    const mockInterval = setInterval(() => {
      void mockApi.getAdminAlerts().then((a) => {
        if (a[0]) setAlerts((prev) => [{ ...a[0], id: `live-${Date.now()}` }, ...prev].slice(0, 20));
      });
    }, 15000);

    es.onerror = () => es.close();

    return () => {
      es.close();
      clearInterval(mockInterval);
    };
  }, []);

  return (
    <>
      <PageHeader title="Admin dashboard" subtitle="Platform KPIs and live alert feed" />
      {isLoading ? (
        <p className="text-slate-500">Loading KPIs…</p>
      ) : (
        <div className="mb-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          {kpis.map((k) => (
            <StatCard key={k.label} label={k.label} value={k.value} hint={k.change} />
          ))}
        </div>
      )}
      <section>
        <h2 className="mb-3 text-lg font-semibold">Live alert feed (SSE + mock)</h2>
        <ul className="space-y-2">
          {alerts.map((a) => (
            <li key={a.id} className="card flex items-start justify-between gap-4 py-3">
              <div>
                <p className="font-medium">{a.patient_name}</p>
                <p className="text-sm text-slate-600">{a.message}</p>
                <p className="mt-1 text-xs text-slate-400">
                  {new Date(a.created_at).toLocaleString('en-NG')}
                </p>
              </div>
              <RiskBadge status={a.risk_status} />
            </li>
          ))}
          {!alerts.length && <p className="text-sm text-slate-500">No alerts yet.</p>}
        </ul>
      </section>
    </>
  );
}
