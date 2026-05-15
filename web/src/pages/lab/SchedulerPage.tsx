import { PageHeader } from '@/components/ui/PageHeader';

const slots = [
  { time: '09:00', patient: 'Grace Okafor', test: 'HbA1c' },
  { time: '10:30', patient: 'Musa Bello', test: 'Fasting glucose' },
  { time: '14:00', patient: 'Esther Adeyemi', test: 'Lipid panel' },
];

export function LabSchedulerPage() {
  return (
    <>
      <PageHeader title="Lab scheduler" subtitle="Today's collection appointments" />
      <div className="grid gap-3 md:grid-cols-2 lg:grid-cols-3">
        {slots.map((s) => (
          <article key={s.time} className="card">
            <p className="text-lg font-bold text-primary">{s.time}</p>
            <p className="font-medium">{s.patient}</p>
            <p className="text-sm text-slate-500">{s.test}</p>
          </article>
        ))}
      </div>
    </>
  );
}
