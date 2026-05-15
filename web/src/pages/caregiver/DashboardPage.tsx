import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { PageHeader } from '@/components/ui/PageHeader';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { mockApi } from '@/lib/mockApi';

export function CaregiverDashboardPage() {
  const { data: patients = [] } = useQuery({
    queryKey: ['patients'],
    queryFn: () => mockApi.getPatients(),
  });

  return (
    <>
      <PageHeader title="Caregiver home" subtitle="Patients you support" />
      <div className="grid gap-4 md:grid-cols-2">
        {patients.map((p) => (
          <article key={p.id} className="card">
            <div className="flex items-start justify-between">
              <p className="font-semibold">{p.full_name}</p>
              <RiskBadge status={p.risk_status} />
            </div>
            <p className="mt-2 text-sm text-slate-500">{p.conditions.join(' · ')}</p>
            <Link to="/caregiver/vitals" className="btn-outline mt-4 inline-block text-xs">
              Log vitals
            </Link>
          </article>
        ))}
      </div>
    </>
  );
}
