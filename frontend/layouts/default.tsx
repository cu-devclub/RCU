import { Head } from "./head";

import { Navbar } from "@/components/navbar";
import { SideNavbar } from "@/components/sidenavbar";

export default function DefaultLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="relative flex flex-col h-screen overflow-hidden">
      <Head />
      <Navbar />
      <div className="flex flex-1 h-full min-h-0">
      <aside className="sticky top-16 h-[calc(100vh-4rem)] w-1/5 min-w-[180px] max-w-xs bg-white border-r">
        <SideNavbar />
      </aside>
      <main className="flex-1 w-4/5 container mx-auto max-w-7xl px-6 overflow-y-auto min-h-0">
        {children}
      </main>
      </div>
    </div>
  );
}
