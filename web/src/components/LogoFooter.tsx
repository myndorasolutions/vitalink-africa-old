export function LogoFooter({ className = '' }: { className?: string }) {
  return (
    <footer className={`flex items-center justify-center gap-2 text-xs text-slate-500 ${className}`}>
      <span>Powered by</span>
      <img src="/myndora-logo.png" alt="Myndora Solutions" className="h-5 object-contain" />
      <span className="font-medium text-slate-600">Myndora Solutions</span>
    </footer>
  );
}
