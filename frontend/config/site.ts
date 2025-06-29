export type SiteConfig = typeof siteConfig;

import { House, Person, Receipt, Building, Hammer } from "react-bootstrap-icons";
import { LuBed } from "react-icons/lu";

export const siteConfig = {
  name: "หอพักนิสิตจุฬาฯ",
  description: "หอพักนิสิตจุฬาลงกรณ์มหาวิทยาลัย (Chulalongkorn University Dormitory)",
  HorizonNavItems: [
    {
      label: "ข้อมูลนิสิตหอพัก",
      href: "/home",
    },
    {
      label: "กิจกรรมหอพัก",
      href: "/activity",
    },
    {
      label: "บุคลากรหอพัก",
      href: "/staff",
    },
    {
      label: "แบบฟอร์มต่างๆ",
      href: "/forms",
    }
  ],
  "/home": [
    {
      label: "หน้าหลัก",
      href: "/home",
      icon: House
    },
    {
      label: "ข้อมูลนิสิต",
      href: "/home/profile",
      icon: Person
    },
    {
      label: "ชำระค่าหอพัก",
      href: "/home/payment",
      icon: Receipt
    },
    {
      label: "สถานะการอยู่หอ",
      href: "/home/dorm_status",
      icon: Building
    },
    {
      label: "สถานะเตียง",
      href: "/home/bed_status",
      icon: LuBed
    },
    {
      label: "แจ้งซ่อม",
      href: "/home/repair",
      icon: Hammer
    }
  ],
  ActivityVerticalNavItems: [],
  StaffVerticalNavItems: [],
  FormsVerticalNavItems: []
};
