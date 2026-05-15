import { useQuery } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { mockApi } from '@/lib/mockApi';
import type { PatientSummary } from '@/lib/types';

export function AdminPatientsPage() {
  const { data = [], isLoading } = useQuery({
    queryKey: ['patients'],
    queryFn: () => mockApi.getPatients(),
  });

  return (
    <>
      <PageHeader title="Patients" subtitle="Registry and risk overview" />
      {isLoading ? (
        <p className="text-slate-500">Loading…</p>
      ) : (
        <DataTable<PatientSummary>
          keyField="id"
          data={data}
          columns={[
            { key: 'full_name', header: 'Name' },
            { key: 'phone', header: 'Phone' },
            { key: 'conditions', header: 'Conditions', render: (r) => r.conditions.join(', ') },
            { key: 'risk_status', header: 'Risk', render: (r) => <RiskBadge status={r.risk_status} /> },
          ]}
        />
      )}
    </>
  );
}
