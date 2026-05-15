import { useQuery } from '@tanstack/react-query';
import { Link, useParams } from 'react-router-dom';
import { PageHeader } from '@/components/ui/PageHeader';
import { mockApi } from '@/lib/mockApi';

export function LabOrderDetailPage() {
  const { orderId } = useParams();
  const { data: orders = [] } = useQuery({
    queryKey: ['lab', 'orders'],
    queryFn: () => mockApi.getLabOrders(),
  });
  const order = orders.find((o) => o.id === orderId) ?? orders[0];

  if (!order) return <p className="text-slate-500">Order not found.</p>;

  return (
    <>
      <PageHeader title={`Order ${order.id}`} subtitle={order.patient_name} />
      <div className="card max-w-lg space-y-3">
        <p><span className="text-slate-500">Tests:</span> {order.tests.join(', ')}</p>
        <p><span className="text-slate-500">Status:</span> <span className="font-medium capitalize">{order.status}</span></p>
        <p><span className="text-slate-500">Ordered:</span> {new Date(order.ordered_at).toLocaleString('en-NG')}</p>
        <div className="flex gap-2 pt-2">
          <Link to="/lab/result-upload" className="btn-primary">Upload results</Link>
          <Link to="/lab/order-queue" className="btn-outline">Back to queue</Link>
        </div>
      </div>
    </>
  );
}
