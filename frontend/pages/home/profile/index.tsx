import { logintitle } from "@/components/primitives";
import LoginLayout from "@/layouts/login";
import { Card, CardBody, CardHeader } from "@heroui/card";
import {Input} from "@heroui/input";
import { Button } from "@heroui/button";
import React from "react";
import { Eye, EyeSlash } from 'react-bootstrap-icons';
import {Image} from "@heroui/image";
import {Spinner} from "@heroui/spinner";
import { useRouter } from "next/router";

import DefaultLayout from "@/layouts/default";

export default function ProfilePage() {

    return (
        <DefaultLayout>
            <h1>Profile page</h1>
        </DefaultLayout>
    );
}