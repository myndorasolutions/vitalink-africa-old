import { Outlet } from 'react-router-dom';
import { LogoFooter } from './LogoFooter';
import { Sidebar } from './Sidebar';

export function Layout() {
  return (
    <div className="flex min-h-screen">
      <Sidebar />
      <div className="flex flex-1 flex-col">
        <main className="flex-1 p-6">
          <Outlet />
        </main>
        <LogoFooter className="border-t border-slate-200 py-4" />
      </div>
    </div>
  );
}
