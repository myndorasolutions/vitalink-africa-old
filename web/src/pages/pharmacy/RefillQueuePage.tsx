import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';
import { mockApi } from '@/lib/mockApi';
import type { RefillRequest } from '@/lib/types';

export function PharmacyRefillQueuePage() {
  const { data = [], isLoading } = useQuery({
    queryKey: ['pharmacy', 'refill-queue'],
    queryFn: () => mockApi.getRefillQueue(),
  });

  return (
    <div>
      <PageHeader
        title="Refill queue"
        subtitle="Pending prescription refills"
        action={
          <Link to="/pharmacy/refill-fulfillment" className="btn-primary">
            Fulfillment
          </Link>
        }
      />
      {isLoading ? (
        <p className="text-slate-500">Loading…</p>
      ) : (
        <DataTable<RefillRequest>
          keyField="id"
          data={data}
          columns={[
            { key: 'patient_name', header: 'Patient' },
            { key: 'medication', header: 'Medication' },
            { key: 'status', header: 'Status' },
            {
              key: 'requested_at',
              header: 'Requested',
              render: (r) => new Date(r.requested_at).toLocaleString('en-NG'),
            },
          ]}
        />
      )}
    </div>
  );
}
