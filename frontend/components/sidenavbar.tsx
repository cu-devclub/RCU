import { siteConfig } from "@/config/site";
import { IconType } from "react-icons";

import { useRouter } from 'next/router';
import { useEffect } from "react";

import { Button } from '@heroui/button'

export const SideNavbar = () => {
  const router = useRouter();

  const currentPath = router.asPath;

  const basePath = currentPath.split('/')[1] ? `/${currentPath.split('/')[1]}` : '/'
  
  useEffect(() => {
      const navItem = document.getElementById(`sidenavitem-${currentPath}`);
      if (navItem) {
          navItem.setAttribute('data-active', 'true');
      }
  })

  return (
    <nav className="flex flex-col gap-4 p-6 min-h-screen h-full border-r border-gray-200">
      <div className="mb-14" /> {/* spacer */}
      {Array.isArray((siteConfig as Record<string, unknown>)[basePath]) &&
        ((siteConfig as Record<string, unknown>)[basePath] as { label: string; href: string; icon: IconType }[]).map((item, idx, arr) => {
          const isActive = item.href === currentPath;
          return (
            <Button
              key={item.href}
              id={`sidenavitem-${item.href}`}
              data-active={isActive}
              variant={isActive ? "flat" : "light"}
              color={isActive ? "success" : "default"}
              className={`flex items-center gap-4 justify-start w-full px-6 py-7 rounded-xl transition-colors text-lg`}
              onPress={() => router.push(item.href)}
            >
              <item.icon className="w-7 h-7" />
              <span>{item.label}</span>
            </Button>
          );
        })}
    </nav>
  )
}