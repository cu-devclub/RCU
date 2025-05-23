import { logintitle } from "@/components/primitives";
import { Card, CardBody, CardHeader } from "@heroui/card";
import {Input} from "@heroui/input";
import { Button } from "@heroui/button";
import { ChevronRight } from 'react-bootstrap-icons';
import {Spinner} from "@heroui/spinner";
import React, { RefObject } from "react";
import { useRouter } from "next/router";

type SendMailCardProps = {
    refere: RefObject<HTMLInputElement>;
    usernameValue: string;
    setUsernameValue: (value: string) => void;
    setRefCode: (value: string) => void;
    goForward: () => void;
};

export default function SendMailCard({
    refere,
    usernameValue,
    setUsernameValue,
    setRefCode,
    goForward,
}: SendMailCardProps) {
    const router = useRouter();
    
    const handleLogin = () => {
        router.push("/login")
    }

    const [waitClick, setWaitClick] = React.useState(false);
    const [nameInvalid, setNameInvalid] = React.useState("");

    const handleForgotPassword = async () => {
        if (usernameValue === "") {
            setNameInvalid("กรุณากรอกชื่อผู้ใช้")
            refere.current?.focus()
            return
        } else {
            setNameInvalid("")
        }

        setWaitClick(true)

        const res = await fetch('/api/sendmail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: usernameValue,
            }),
        })

        const data = await res.json()
        if (data.success) {
            setWaitClick(false)
            setRefCode(data.ref_code)
            goForward()
        } else {
            refere.current?.focus()
            setNameInvalid(data.msg)
            setWaitClick(false)
        }
    }



    return (
        <Card>
            <CardHeader className="text-center mb-1">
                <h1 className={logintitle()}>ลืมรหัสผ่าน</h1>
            </CardHeader>
            <CardBody>
                <Input
                    ref={refere}
                    label="ชื่อผู้ใข้"
                    type="text"
                    className="mb-4"
                    variant="bordered"
                    value={usernameValue}
                    onChange={(e) => setUsernameValue(e.target.value)}
                    errorMessage={nameInvalid}
                    isInvalid={nameInvalid !== ""}
                    onKeyDown={(e) => {
                        if (e.key === 'Enter') {
                            e.preventDefault()
                            handleForgotPassword()
                        }
                    }}
                />
                <div className="grid grid-cols-2 gap-2">
                    <a
                        className="ml-1 text-gray-600 cursor-pointer"
                        onClick={handleLogin}
                    >
                        เข้าสู่ระบบ?
                    </a>
                    <Button
                        color={waitClick ? "default" : "primary"}
                        onPress={handleForgotPassword}
                        disabled={waitClick}
                        isIconOnly
                        className="justify-self-end mr-4"
                    >
                        {!waitClick ? (
                            <ChevronRight />
                        ) : (
                            <Spinner color="primary" size="sm" />
                        )}
                    </Button>
                </div>
            </CardBody>
        </Card>
    )
}