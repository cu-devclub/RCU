export type SiteConfig = typeof siteConfig;

export const siteConfig = {
  name: "หอพักนิสิตจุฬาฯ",
  description: "หอพักนิสิตจุฬาลงกรณ์มหาวิทยาลัย (Chulalongkorn University Dormitory)",
  HorizonNavItems: [
    {
      label: "หน้าแรก",
      href: "/",
    },
    {
      label: "ชำระค่าหอพัก",
      href: "/payment",
    },
    {
      label: "สถานะการอยู่หอ",
      href: "/Dormstatus",
    },
    {
      label: "สถานะเตียง",
      href: "/roomstatus",
    },
    {
      label: "แจ้งซ่อม",
      href: "/repair",
    },
  ],
  VerticalNavItems: [
    {
      label: "ข้อมูลนิสิตหอพัก",
      href: "/",
    },
    {
      label: "กิจกรรมหอพัก",
      href: "/",
    },
    {
      label: "บุคลากรหอพัก",
      href: "/",
    },
    {
      label: "แบบฟอร์มต่างๆ",
      href: "/",
    },
  ],
  navItems: [
    {
      label: "Home",
      href: "/",
    },
    {
      label: "Docs",
      href: "/docs",
    },
    {
      label: "Pricing",
      href: "/pricing",
    },
    {
      label: "Blog",
      href: "/blog",
    },
    {
      label: "About",
      href: "/about",
    },
  ],
  navMenuItems: [
    {
      label: "Profile",
      href: "/profile",
    },
    {
      label: "Dashboard",
      href: "/dashboard",
    },
    {
      label: "Projects",
      href: "/projects",
    },
    {
      label: "Team",
      href: "/team",
    },
    {
      label: "Calendar",
      href: "/calendar",
    },
    {
      label: "Settings",
      href: "/settings",
    },
    {
      label: "Help & Feedback",
      href: "/help-feedback",
    },
    {
      label: "Logout",
      href: "/logout",
    },
  ],
  links: {
    github: "https://github.com/heroui-inc/heroui",
    twitter: "https://twitter.com/hero_ui",
    docs: "https://heroui.com",
    discord: "https://discord.gg/9b6yyZKmH4",
    sponsor: "https://patreon.com/jrgarciadev",
  },
};
