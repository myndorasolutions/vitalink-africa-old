import { PageHeader } from '@/components/ui/PageHeader';

const items = [
  { title: 'NDPR data processing register', status: 'current', due: '2026-12-01' },
  { title: 'Provider license audit', status: 'review', due: '2026-06-01' },
  { title: 'Clinical safety incident log', status: 'current', due: 'ongoing' },
];

export function AdminCompliancePage() {
  return (
    <>
      <PageHeader title="Compliance" subtitle="Regulatory checklist" />
      <ul className="space-y-3">
        {items.map((item) => (
          <li key={item.title} className="card flex justify-between gap-4">
            <span className="font-medium">{item.title}</span>
            <span className={`text-sm ${item.status === 'current' ? 'text-success' : 'text-warning'}`}>
              {item.status} · {item.due}
            </span>
          </li>
        ))}
      </ul>
    </>
  );
}
