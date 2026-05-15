import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';
import { mockApi } from '@/lib/mockApi';
import type { LabOrder } from '@/lib/types';

export function LabOrderQueuePage() {
  const { data = [], isLoading } = useQuery({
    queryKey: ['lab', 'orders'],
    queryFn: () => mockApi.getLabOrders(),
  });

  return (
    <>
      <PageHeader title="Lab order queue" subtitle="Incoming test orders" />
      {isLoading ? (
        <p className="text-slate-500">Loading…</p>
      ) : (
        <DataTable<LabOrder>
          keyField="id"
          data={data}
          onRowClick={() => {}}
          columns={[
            { key: 'patient_name', header: 'Patient' },
            { key: 'tests', header: 'Tests', render: (r) => r.tests.join(', ') },
            { key: 'status', header: 'Status' },
            {
              key: 'id',
              header: '',
              render: (r) => <Link to={`/lab/orders/${r.id}`} className="text-primary">View</Link>,
            },
          ]}
        />
      )}
    </>
  );
}
