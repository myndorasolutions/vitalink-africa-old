import { PageHeader } from '@/components/ui/PageHeader';
import { getApiBaseUrl } from '@/lib/api';

export function SystemConfigPage() {
  return (
    <>
      <PageHeader title="System config" subtitle="Environment and integrations" />
      <form className="card max-w-xl space-y-4">
        <div>
          <label className="label">API base URL</label>
          <input className="input" readOnly value={getApiBaseUrl()} />
        </div>
        <div>
          <label className="label">Escrow auto-release (hours)</label>
          <input className="input" type="number" defaultValue={48} />
        </div>
        <div>
          <label className="label">Mock Paystack</label>
          <select className="input" defaultValue="true">
            <option value="true">Enabled</option>
            <option value="false">Disabled</option>
          </select>
        </div>
        <button type="button" className="btn-primary">Save configuration</button>
      </form>
    </>
  );
}
