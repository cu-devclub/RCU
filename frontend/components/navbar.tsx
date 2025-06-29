import {
  Navbar as HeroUINavbar,
  NavbarContent,
  NavbarBrand,
  NavbarItem,
} from "@heroui/navbar";
import { Button } from "@heroui/button";
import { useRouter } from 'next/router';
import { useEffect } from "react";
import { link as linkStyles } from "@heroui/theme";
import NextLink from "next/link";
import clsx from "clsx";

import { siteConfig } from "@/config/site";

import { BoxArrowRight } from "react-bootstrap-icons";

export const Navbar = () => {
  const router = useRouter();

  const currentPath = router.asPath;
  
  useEffect(() => {
      const basePath = currentPath.split('/')[1] ? `/${currentPath.split('/')[1]}` : '/';
      const navItem = document.getElementById(`navitem-${basePath}`);
      if (navItem) {
          navItem.setAttribute('data-active', 'true');
      }
  })

  const logout = async () => {
    await fetch('/api/logout', {
      method: 'POST',
    });
    router.push('/login');
  };

  return (
    <HeroUINavbar maxWidth="full" position="sticky" className="border-b border-gray-400">
      <NavbarContent className="basis-1/5 sm:basis-full" justify="start">
        <NavbarBrand className="gap-3 max-w-fit">
            <NextLink className="flex justify-start items-center gap-1" href="/">
            <img
              src="/images/chula_logo.png"
              className="h-[2.5rem] w-auto"
              style={{ objectFit: "contain" }}
              alt="Chula Logo"
            />
            <div className="leading-none">
              <p className="font-bold" style={{ color: "#DB5F8E" }}>สำนักงานหอพักนิสิต</p>
              <p style={{ color: "#898989" }}>จุฬาลงกรณ์มหาวิทยาลัย</p>
            </div>
            </NextLink>
        </NavbarBrand>
        <div className="hidden lg:flex gap-4 justify-start ml-2">
          {siteConfig.HorizonNavItems.map((item) => (
            <NavbarItem key={item.href}>
                <NextLink
                  className={clsx(
                  linkStyles({ color: "foreground" }),
                  "py-3",
                  "data-[active=true]:text-black data-[active=true]:font-medium data-[active=true]:border-b-2 data-[active=true]:border-[#DB5F8E]"
                  )}
                  color="foreground"
                  href={item.href}
                  id={`navitem-${item.href}`}
                >
                  {item.label}
                </NextLink>
            </NavbarItem>
          ))}
        </div>
      </NavbarContent>

      <NavbarContent
        className="hidden sm:flex basis-1/5 sm:basis-full"
        justify="end"
      >
        <NavbarItem>
          <Button
            variant="light"
            className="flex items-center gap-2 font-medium"
            endContent={<BoxArrowRight className="text-lg" />}
            onPress={logout}
          >
            ออกจากระบบ
          </Button>
        </NavbarItem>
      </NavbarContent>
    </HeroUINavbar>
  );
};
