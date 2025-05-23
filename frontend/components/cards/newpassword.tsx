import { logintitle } from "@/components/primitives";
import { Card, CardBody, CardHeader } from "@heroui/card";
import {Input} from "@heroui/input";
import { Button } from "@heroui/button";
import { Eye, EyeSlash, ChevronLeft } from 'react-bootstrap-icons';
import {Spinner} from "@heroui/spinner";
import React, { RefObject } from "react";
import { useRouter } from "next/router";

type NewPassCardProps = {
    refere: RefObject<HTMLInputElement>;
    fullRefCode: string;
    usernameValue: string;
    backButton: () => void;
    goForward: () => void;
};

export default function NewPassCard({
    refere,
    fullRefCode,
    usernameValue,
    backButton,
    goForward
}: NewPassCardProps) {
    const router = useRouter();

    const passConfirmRef = React.useRef<HTMLInputElement>(null)

    const [isVisible, setIsVisible] = React.useState(false);
        
    const [password, setPassword] = React.useState("");
    const [confirmPassword, setConfirmPassword] = React.useState("");

    const [passwordInvalid, setPasswordInvalid] = React.useState("");
    const [confirmPasswordInvalid, setConfirmPasswordInvalid] = React.useState("");

    const toggleVisibility = () => setIsVisible(!isVisible);

    const [waitClick, setWaitClick] = React.useState(false);

    const updatePasswordHandler = async () => {
        if (password === "") {
            setPasswordInvalid("กรุณากรอกรหัสผ่าน")
            refere.current?.focus()
            return
        }

        if (confirmPassword === "") {
            setConfirmPasswordInvalid("กรุณากรอกรหัสผ่าน")
            passConfirmRef.current?.focus()
            return
        }

        if (password !== confirmPassword) {
            setConfirmPasswordInvalid("รหัสผ่านไม่ตรงกัน")
            passConfirmRef.current?.focus()
            return
        }

        setWaitClick(true)

        const res = await fetch('/api/resetpassword', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: usernameValue,
                full_ref_code: fullRefCode,
                password: password,
            }),
        })

        const data = await res.json()
        if (data.success) {
            setWaitClick(false)
            goForward()
        } else {
            refere.current?.focus()
            setConfirmPasswordInvalid(data.msg)
            setWaitClick(false)
        }
    }

    return (
        <Card>
            <CardHeader className="text-center mb-1">
                <h1 className={logintitle()}>ตั้งรหัสผ่านใหม่</h1>
            </CardHeader>
            <CardBody className="overflow-hidden">
                <Input
                    ref={refere}
                    className="max-w-xs  mb-1"
                    endContent={
                        <button
                            aria-label="เปิดปิดการแสดงรหัสผ่าน"
                            className="focus:outline-none"
                            type="button"
                            onClick={toggleVisibility}
                        >
                            {isVisible ? (
                                <EyeSlash className="text-2xl text-default-400 pointer-events-none" />
                            ) : (
                                <Eye className="text-2xl text-default-400 pointer-events-none" />
                            )}
                        </button>
                    }
                    label="รหัสผ่าน"
                    type={isVisible ? "text" : "password"}
                    variant="bordered"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    errorMessage={passwordInvalid}
                    isInvalid={passwordInvalid !== ""}
                    onKeyDown={(e) => {
                        if (e.key === 'Enter') {
                            e.preventDefault()
                            passConfirmRef.current?.focus()
                        }
                    }}
                />
                <Input
                    ref={passConfirmRef}
                    className="max-w-xs  mb-1"
                    endContent={
                        <button
                            aria-label="เปิดปิดการแสดงรหัสผ่าน"
                            className="focus:outline-none"
                            type="button"
                            onClick={toggleVisibility}
                        >
                            {isVisible ? (
                                <EyeSlash className="text-2xl text-default-400 pointer-events-none" />
                            ) : (
                                <Eye className="text-2xl text-default-400 pointer-events-none" />
                            )}
                        </button>
                    }
                    label="ยืนยันรหัสผ่าน"
                    type={isVisible ? "text" : "password"}
                    variant="bordered"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    errorMessage={confirmPasswordInvalid}
                    isInvalid={confirmPasswordInvalid !== ""}
                    onKeyDown={(e) => {
                        if (e.key === 'Enter') {
                            e.preventDefault()
                            updatePasswordHandler()
                        }
                    }}
                />
                <div className="flex justify-between mt-4">
                    <Button 
                        onPress={backButton} 
                        color="default"
                        isIconOnly
                    >
                        <ChevronLeft />
                    </Button>
                    <Button
                        color={waitClick ? "default" : "primary"}
                        onPress={updatePasswordHandler}
                        disabled={waitClick}
                        className="justify-self-end"
                    >
                        {!waitClick ? (
                            "เปลี่ยนรหัสผ่าน"
                        ) : (
                            <Spinner color="primary" size="sm" />
                        )}
                    </Button>
                </div>
            </CardBody>
        </Card>
    )
}