import { PageHeader } from '@/components/ui/PageHeader';

export function AdminReportsPage() {
  const reports = [
    { name: 'Monthly vitals summary', format: 'CSV' },
    { name: 'Escrow reconciliation', format: 'PDF' },
    { name: 'Provider performance', format: 'CSV' },
  ];

  return (
    <>
      <PageHeader title="Reports" subtitle="Export platform analytics" />
      <div className="grid gap-4 md:grid-cols-2">
        {reports.map((r) => (
          <article key={r.name} className="card flex items-center justify-between">
            <div>
              <p className="font-semibold">{r.name}</p>
              <p className="text-sm text-slate-500">{r.format}</p>
            </div>
            <button type="button" className="btn-primary">Generate</button>
          </article>
        ))}
      </div>
    </>
  );
}
