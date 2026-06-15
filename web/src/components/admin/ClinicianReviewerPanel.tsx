import { useState } from 'react';
import { RiskBadge } from '@/components/ui/RiskBadge';
import {
  initialReviewQueue,
  type FlaggedVitalReview,
  type ReviewStatus,
} from '@/lib/reviewQueue';

const statusLabel: Record<ReviewStatus, string> = {
  needs_review: 'Needs Review',
  reviewed: 'Reviewed',
  closed: 'Closed',
};

export function ClinicianReviewerPanel() {
  const [rows, setRows] = useState<FlaggedVitalReview[]>(initialReviewQueue);
  const [feedback, setFeedback] = useState<string | null>(null);

  const updateRow = (
    id: string,
    status: ReviewStatus,
    notes?: string,
  ) => {
    setRows((prev) =>
      prev.map((row) =>
        row.id === id
          ? {
              ...row,
              status,
              clinicianNotes: notes ?? row.clinicianNotes,
            }
          : row,
      ),
    );
    setFeedback(
      status === 'reviewed'
        ? 'Marked reviewed — pilot simulator state updated.'
        : 'Marked closed — pilot simulator state updated.',
    );
    window.setTimeout(() => setFeedback(null), 4000);
  };

  return (
    <section className="mt-8">
      <h2 className="mb-1 text-lg font-semibold">Clinician Reviewer (pilot simulator)</h2>
      <p className="mb-4 text-sm text-slate-500">
        Pilot simulator for closed-test coordinators — status changes update local state only.
      </p>
      {feedback && (
        <div className="mb-4 rounded-lg border border-green-200 bg-green-50 px-4 py-2 text-sm text-green-800">
          {feedback}
        </div>
      )}
      <ul className="space-y-3">
        {rows.map((row) => (
          <li key={row.id} className="card space-y-3 p-4">
            <div className="flex flex-wrap items-start justify-between gap-3">
              <div>
                <p className="font-medium">{row.patientName}</p>
                <p className="text-sm text-slate-600">
                  BP {row.systolic}/{row.diastolic} mmHg
                </p>
                <p className="mt-1 text-xs text-slate-400">
                  {new Date(row.createdAt).toLocaleString('en-NG')}
                </p>
              </div>
              <div className="flex items-center gap-2">
                <RiskBadge status={row.riskStatus} />
                <span className="rounded-full bg-slate-100 px-2 py-1 text-xs font-medium text-slate-700">
                  {statusLabel[row.status]}
                </span>
              </div>
            </div>
            <textarea
              className="input min-h-[72px] w-full text-sm"
              placeholder="Mock clinician notes"
              value={row.clinicianNotes}
              onChange={(e) => updateRow(row.id, row.status, e.target.value)}
              disabled={row.status !== 'needs_review'}
            />
            {row.status === 'needs_review' && (
              <div className="flex flex-wrap gap-2">
                <button
                  type="button"
                  className="btn-primary text-xs"
                  data-testid={`clinician-reviewer-mark-reviewed-${row.id}`}
                  onClick={() =>
                    updateRow(
                      row.id,
                      'reviewed',
                      row.clinicianNotes || 'Reviewed during pilot track.',
                    )
                  }
                >
                  Mark Reviewed
                </button>
                <button
                  type="button"
                  className="btn-outline text-xs"
                  data-testid={`clinician-reviewer-mark-closed-${row.id}`}
                  onClick={() =>
                    updateRow(
                      row.id,
                      'closed',
                      row.clinicianNotes || 'Closed — no further action.',
                    )
                  }
                >
                  Mark Closed
                </button>
              </div>
            )}
          </li>
        ))}
      </ul>
    </section>
  );
}
