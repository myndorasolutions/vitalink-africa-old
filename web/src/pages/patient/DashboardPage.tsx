import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { PageHeader } from '@/components/ui/PageHeader';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { StatCard } from '@/components/ui/StatCard';
import { mockApi } from '@/lib/mockApi';

export function PatientDashboardPage() {
  const { data: vitals = [] } = useQuery({
    queryKey: ['vitals', 'p1'],
    queryFn: () => mockApi.getVitalsTrend('p1', 7),
  });
  const latest = vitals[vitals.length - 1];

  return (
    <>
      <PageHeader
        title="Your health"
        subtitle="Hypertension & diabetes care plan"
        action={latest && <RiskBadge status={latest.risk_status} />}
      />
      <div className="mb-6 grid gap-4 sm:grid-cols-3">
        <StatCard label="Latest BP" value={latest ? `${latest.systolic_bp}/${latest.diastolic_bp}` : '—'} />
        <StatCard label="Pulse" value={latest?.pulse ?? '—'} />
        <StatCard label="Glucose" value={latest?.glucose_fasting ?? '—'} />
      </div>
      <div className="flex flex-wrap gap-3">
        <Link to="/patient/vitals" className="btn-primary">View trends</Link>
        <Link to="/patient/medications" className="btn-outline">Medications</Link>
      </div>
    </>
  );
}
