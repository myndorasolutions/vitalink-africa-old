import { PageHeader } from '@/components/ui/PageHeader';

export function ChwCheckupPortalPage() {
  return (
    <>
      <PageHeader
        title="CHW field checkup portal"
        subtitle="Physical visits are captured in the Windows desktop field app"
      />
      <div className="card max-w-2xl space-y-4">
        <p className="text-slate-600">
          Community Health Workers use the Myndora Care desktop app for guided vitals capture,
          Yoruba audio prompts, and zero-cost visit verification (signature canvas or 4-digit OTP).
        </p>
        <div className="rounded-lg bg-slate-50 p-4 font-mono text-sm">
          flutter run -d windows --debug \<br />
          &nbsp;&nbsp;--dart-define=INTEGRATION_FLOW=true \<br />
          &nbsp;&nbsp;--dart-define=API_BASE_URL=http://localhost:8080/api/v1
        </div>
        <p className="text-sm text-slate-500">
          Sign in as <strong>Community Health Worker</strong> on the login screen, then complete
          checkups from the integration checkup form.
        </p>
      </div>
    </>
  );
}
