import { useQuery } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { StatCard } from '@/components/ui/StatCard';
import { DataTable } from '@/components/ui/DataTable';
import { mockApi } from '@/lib/mockApi';

export function ClinicianEarningsPage() {
  const { data, isLoading } = useQuery({
    queryKey: ['clinician', 'earnings'],
    queryFn: () => mockApi.getEarnings('clinician'),
  });

  return (
    <>
      <PageHeader title="Clinician earnings" subtitle={data?.period} />
      {isLoading ? (
        <p className="text-slate-500">Loading…</p>
      ) : (
        <>
          <div className="mb-6 grid gap-4 sm:grid-cols-3">
            <StatCard label="Gross (₦)" value={(data?.gross_naira ?? 0).toLocaleString('en-NG')} />
            <StatCard label="Commission (₦)" value={(data?.commission_naira ?? 0).toLocaleString('en-NG')} />
            <StatCard label="Pending (₦)" value={(data?.pending_payout_naira ?? 0).toLocaleString('en-NG')} />
          </div>
          <DataTable keyField="id" data={data?.transactions ?? []} columns={[
            { key: 'date', header: 'Date' },
            { key: 'description', header: 'Description' },
            { key: 'amount', header: '₦', render: (r) => Number(r.amount).toLocaleString('en-NG') },
          ]} />
        </>
      )}
    </>
  );
}
