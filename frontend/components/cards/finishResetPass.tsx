import { logintitle } from "@/components/primitives";
import { Card, CardBody, CardHeader } from "@heroui/card";
import { Button } from "@heroui/button";
import React from "react";
import { useRouter } from "next/router";

export default function FinishResetPassCard() {
    const router = useRouter();
    
    const handleLogin = () => {
        router.push("/login")
    }

    return (
        <Card>
            <CardHeader className="text-center mb-1">
                <h1 className={logintitle()}>เปลี่ยนรหัสผ่านเสร็จสิ้น</h1>
            </CardHeader>
            <CardBody>
                <p className="text-sm text-gray-800 mb-6 text-center">กรุณาเข้าสู่ระบบโดยใช้รหัสผ่านใหม่</p>
                <Button
                    color="primary"
                    onPress={handleLogin}
                    className="justify-self-center"
                >
                    เข้าสู่ระบบ
                </Button>
            </CardBody>
        </Card>
    )
}