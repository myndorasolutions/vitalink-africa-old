import { PageHeader } from '@/components/ui/PageHeader';

const meds = [
  { name: 'Amlodipine 5mg', schedule: 'Once daily · morning', next_refill: '2026-05-22' },
  { name: 'Metformin 500mg', schedule: 'Twice daily · with meals', next_refill: '2026-05-20' },
];

export function PatientMedicationsPage() {
  return (
    <>
      <PageHeader title="Medications" subtitle="Active prescriptions" />
      <ul className="space-y-3">
        {meds.map((m) => (
          <li key={m.name} className="card">
            <p className="font-semibold">{m.name}</p>
            <p className="text-sm text-slate-500">{m.schedule}</p>
            <p className="mt-2 text-xs text-primary">Next refill: {m.next_refill}</p>
          </li>
        ))}
      </ul>
    </>
  );
}
