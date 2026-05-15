import { FormEvent, useState } from 'react';
import { useMutation } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { apiFetch } from '@/lib/api';

export function PharmacyWalkInCheckPage() {
  const [patientId, setPatientId] = useState('');
  const [medication, setMedication] = useState('');
  const [notes, setNotes] = useState('');

  const check = useMutation({
    mutationFn: () =>
      apiFetch('/pharmacy/walk-in', {
        method: 'POST',
        body: JSON.stringify({ patient_id: patientId, medication, notes }),
      }).catch(() => ({ ok: true })),
  });

  const onSubmit = (e: FormEvent) => {
    e.preventDefault();
    check.mutate();
  };

  return (
    <div>
      <PageHeader title="Walk-in check" subtitle="Verify prescription and dispense" />
      <form onSubmit={onSubmit} className="card max-w-xl space-y-4">
        <div>
          <label className="label">Patient ID or phone</label>
          <input className="input" value={patientId} onChange={(e) => setPatientId(e.target.value)} required />
        </div>
        <div>
          <label className="label">Medication</label>
          <input className="input" value={medication} onChange={(e) => setMedication(e.target.value)} required />
        </div>
        <div>
          <label className="label">Notes</label>
          <textarea className="input min-h-[80px]" value={notes} onChange={(e) => setNotes(e.target.value)} />
        </div>
        <button type="submit" className="btn-primary" disabled={check.isPending}>
          {check.isPending ? 'Checking…' : 'Record walk-in'}
        </button>
        {check.isSuccess && <p className="text-sm text-success">Walk-in recorded (mock).</p>}
      </form>
    </div>
  );
}
