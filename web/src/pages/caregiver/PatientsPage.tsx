import { useQuery } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { mockApi } from '@/lib/mockApi';
import type { PatientSummary } from '@/lib/types';

export function CaregiverPatientsPage() {
  const { data = [] } = useQuery({
    queryKey: ['patients'],
    queryFn: () => mockApi.getPatients(),
  });

  return (
    <>
      <PageHeader title="My patients" />
      <DataTable<PatientSummary>
        keyField="id"
        data={data}
        columns={[
          { key: 'full_name', header: 'Name' },
          { key: 'phone', header: 'Phone' },
          { key: 'risk_status', header: 'Risk', render: (r) => <RiskBadge status={r.risk_status} /> },
        ]}
      />
    </>
  );
}
