import { PageHeader } from '@/components/ui/PageHeader';
import { DataTable } from '@/components/ui/DataTable';
import { StatCard } from '@/components/ui/StatCard';

const payments = [
  { id: 'pay1', reference: 'VL-20260515-001', amount: 5000, status: 'released', type: 'service' },
  { id: 'pay2', reference: 'VL-20260514-088', amount: 12000, status: 'paid_held', type: 'subscription' },
];

export function AdminPaymentsPage() {
  return (
    <>
      <PageHeader title="Payments & escrow" subtitle="Paystack transactions" />
      <div className="mb-6 grid gap-4 sm:grid-cols-3">
        <StatCard label="Held escrow (₦)" value="2.4M" />
        <StatCard label="Released (7d)" value="890K" />
        <StatCard label="Disputes" value={2} />
      </div>
      <DataTable keyField="id" data={payments} columns={[
        { key: 'reference', header: 'Reference' },
        { key: 'type', header: 'Type' },
        { key: 'amount', header: '₦', render: (r) => Number(r.amount).toLocaleString('en-NG') },
        { key: 'status', header: 'Escrow status' },
      ]} />
    </>
  );
}
