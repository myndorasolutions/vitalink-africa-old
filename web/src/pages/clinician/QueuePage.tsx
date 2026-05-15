import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';
import { RiskBadge } from '@/components/ui/RiskBadge';
import { mockApi } from '@/lib/mockApi';
import type { ConsultQueueItem } from '@/lib/types';

export function ClinicianQueuePage() {
  const { data = [], isLoading } = useQuery({
    queryKey: ['clinician', 'queue'],
    queryFn: () => mockApi.getClinicianQueue(),
  });

  return (
    <div>
      <PageHeader title="Consultation queue" subtitle="Patients waiting for review" />
      {isLoading ? (
        <p className="text-slate-500">Loading…</p>
      ) : (
        <DataTable<ConsultQueueItem>
          keyField="id"
          data={data}
          onRowClick={() => {}}
          columns={[
            { key: 'patient_name', header: 'Patient' },
            { key: 'reason', header: 'Reason' },
            {
              key: 'risk_status',
              header: 'Risk',
              render: (r) => <RiskBadge status={r.risk_status} />,
            },
            { key: 'wait_minutes', header: 'Wait (min)' },
            {
              key: 'id',
              header: '',
              render: () => (
                <Link to="/clinician/consultation-note" className="text-primary hover:underline">
                  Open
                </Link>
              ),
            },
          ]}
        />
      )}
    </div>
  );
}
