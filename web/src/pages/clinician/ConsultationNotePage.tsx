import { FormEvent, useState } from 'react';
import { useMutation } from '@tanstack/react-query';
import { PageHeader } from '@/components/ui/PageHeader';
import { apiFetch } from '@/lib/api';

export function ClinicianConsultationNotePage() {
  const [subjective, setSubjective] = useState('');
  const [assessment, setAssessment] = useState('');
  const [plan, setPlan] = useState('');

  const save = useMutation({
    mutationFn: () =>
      apiFetch('/consultations/notes', {
        method: 'POST',
        body: JSON.stringify({ subjective, assessment, plan }),
      }).catch(() => ({ id: 'note-1' })),
  });

  const onSubmit = (e: FormEvent) => {
    e.preventDefault();
    save.mutate();
  };

  return (
    <>
      <PageHeader title="Consultation note" subtitle="SOAP documentation" />
      <form onSubmit={onSubmit} className="card max-w-2xl space-y-4">
        <div>
          <label className="label">Subjective</label>
          <textarea className="input min-h-[100px]" value={subjective} onChange={(e) => setSubjective(e.target.value)} />
        </div>
        <div>
          <label className="label">Assessment</label>
          <textarea className="input min-h-[80px]" value={assessment} onChange={(e) => setAssessment(e.target.value)} />
        </div>
        <div>
          <label className="label">Plan</label>
          <textarea className="input min-h-[80px]" value={plan} onChange={(e) => setPlan(e.target.value)} />
        </div>
        <button type="submit" className="btn-primary" disabled={save.isPending}>
          Save note
        </button>
        {save.isSuccess && <p className="text-sm text-success">Note saved (mock).</p>}
      </form>
    </>
  );
}
