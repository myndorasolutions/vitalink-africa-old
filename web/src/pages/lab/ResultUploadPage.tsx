import { FormEvent, useState } from 'react';
import { PageHeader } from '@/components/ui/PageHeader';

export function LabResultUploadPage() {
  const [orderId, setOrderId] = useState('lo1');
  const [file, setFile] = useState<File | null>(null);
  const [values, setValues] = useState('HbA1c: 7.2%');

  const onSubmit = (e: FormEvent) => {
    e.preventDefault();
    alert(`Uploaded results for ${orderId} (mock)${file ? `: ${file.name}` : ''}`);
  };

  return (
    <>
      <PageHeader title="Result upload" subtitle="Attach lab results to orders" />
      <form onSubmit={onSubmit} className="card max-w-xl space-y-4">
        <div>
          <label className="label">Order ID</label>
          <input className="input" value={orderId} onChange={(e) => setOrderId(e.target.value)} />
        </div>
        <div>
          <label className="label">Result values</label>
          <textarea className="input min-h-[100px]" value={values} onChange={(e) => setValues(e.target.value)} />
        </div>
        <div>
          <label className="label">PDF / image</label>
          <input type="file" accept=".pdf,image/*" onChange={(e) => setFile(e.target.files?.[0] ?? null)} />
        </div>
        <button type="submit" className="btn-primary">Upload results</button>
      </form>
    </>
  );
}
