import { useQuery } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { StatCard } from '@/components/ui/StatCard';
import { mockApi } from '@/lib/mockApi';

export function PharmacyDashboardPage() {
  const { data, isLoading } = useQuery({
    queryKey: ['pharmacy', 'dashboard'],
    queryFn: () => mockApi.getPharmacyDashboard(),
  });

  return (
    <div>
      <PageHeader title="Pharmacy dashboard" subtitle="Today's dispensing overview" />
      {isLoading ? (
        <p className="text-slate-500">Loading…</p>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          <StatCard label="Pending refills" value={data?.pending_refills ?? 0} />
          <StatCard label="Walk-ins today" value={data?.walk_ins_today ?? 0} />
          <StatCard label="Dispensed today" value={data?.dispensed_today ?? 0} />
          <StatCard
            label="Revenue (₦)"
            value={(data?.revenue_naira ?? 0).toLocaleString('en-NG')}
          />
        </div>
      )}
    </div>
  );
}
