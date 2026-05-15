import { useQuery } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { mockApi } from '@/lib/mockApi';

export function PharmacyRefillFulfillmentPage() {
  const { data = [] } = useQuery({
    queryKey: ['pharmacy', 'refill-queue'],
    queryFn: () => mockApi.getRefillQueue(),
  });

  const ready = data.filter((r) => r.status === 'ready' || r.status === 'pending');

  return (
    <div>
      <PageHeader title="Refill fulfillment" subtitle="Mark refills as dispensed" />
      <div className="space-y-4">
        {ready.map((r) => (
          <div key={r.id} className="card flex flex-wrap items-center justify-between gap-4">
            <div>
              <p className="font-semibold">{r.patient_name}</p>
              <p className="text-sm text-slate-500">{r.medication}</p>
            </div>
            <div className="flex gap-2">
              <button type="button" className="btn-outline">
                Print label
              </button>
              <button type="button" className="btn-primary">
                Mark dispensed
              </button>
            </div>
          </div>
        ))}
        {!ready.length && <p className="text-slate-500">No refills ready for fulfillment.</p>}
      </div>
    </div>
  );
}
