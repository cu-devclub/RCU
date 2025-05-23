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

export default function LoginPage() {
    const router = useRouter();
    const [isVisible, setIsVisible] = React.useState(false);
    const [waitClick, setWaitClick] = React.useState(false);
    
    const [username, setUsername] = React.useState("");
    const [password, setPassword] = React.useState("");

    const [nameInvalid, setNameInvalid] = React.useState("");
    const [passInvalid, setPassInvalid] = React.useState("");

    const usernameRef = React.useRef<HTMLInputElement>(null)
    const passwordRef = React.useRef<HTMLInputElement>(null)

    const toggleVisibility = () => setIsVisible(!isVisible);

    React.useEffect(() => {
        usernameRef.current?.focus()
    }, [])

    const handleForgotPassword = () => {
        router.push("/forgot-password")
    }

    const handleClick = async () => {
        if (username === "") {
            setNameInvalid("กรุณากรอกชื่อผู้ใช้")
            usernameRef.current?.focus()
            return
        } else {
            setNameInvalid("")
        }

        if (password === "") {
            setPassInvalid("กรุณากรอกรหัสผ่าน")
            passwordRef.current?.focus()
            return
        } else {
            setPassInvalid("")
        }

        setWaitClick(true)

        const res = await fetch('/api/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: username,
                password: password,
            }),
        })  
        

        const data = await res.json()
        if (data.success) {
            router.push("/")
        } else {
            usernameRef.current?.focus()
            setNameInvalid("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง")
            setWaitClick(false)
        }
        
    }

    return (
        <LoginLayout>
            <div
                className="min-h-screen w-screen flex items-center justify-center relative"
                style={{
                    backgroundImage: "url('/images/login_bg.jpg')",
                    backgroundSize: 'cover',
                    backgroundPosition: 'center',
                    backgroundRepeat: 'no-repeat',
                    backgroundAttachment: 'fixed',
                }}
            >
                {/* Semi-transparent overlay */}
                <div className="absolute inset-0 bg-black/50 z-0" />

                {/* Card container */}
                <div className="relative z-10 -translate-y-20">
                    <div className="flex justify-center mb-6">
                        <Image
                            src="/images/logo.png"
                            width={100}
                        />
                    </div>
                    <Card>
                        <CardHeader className="text-center mb-1">
                            <h1 className={logintitle()}>หอพักนิสิตจุฬาฯ</h1>
                        </CardHeader>
                        <CardBody>
                            <Input
                                ref={usernameRef}
                                label="ชื่อผู้ใข้" 
                                type="text" 
                                className="mb-4"
                                variant="bordered" 
                                value={username}
                                onChange={(e) => setUsername(e.target.value)}
                                errorMessage={nameInvalid}
                                isInvalid={nameInvalid !== ""}
                                onKeyDown={(e) => {
                                    if (e.key === 'Enter') {
                                        e.preventDefault()
                                        passwordRef.current?.focus()
                                    }
                                }}
                                />
                            <Input
                                ref={passwordRef}
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
                                errorMessage={passInvalid}
                                isInvalid={passInvalid !== ""}
                                onKeyDown={(e) => {
                                    if (e.key === 'Enter') {
                                        e.preventDefault()
                                        handleClick()
                                    }
                                }}
                            />
                            <a className="mb-4 ml-1 text-gray-600 cursor-pointer" onClick={handleForgotPassword}>ลืมรหัสผ่าน?</a>
                            <Button 
                                color={waitClick ? "default" : "primary"}
                                onPress={handleClick} 
                                disabled={waitClick}
                            >
                                    {!waitClick ? "เข้าสู่ระบบ" : <Spinner color="primary" size="sm"/>}
                            </Button>
                        </CardBody>
                    </Card>
                </div>
            </div>
        </LoginLayout>
    );
}