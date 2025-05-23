import { logintitle } from "@/components/primitives";
import { Card, CardBody, CardHeader } from "@heroui/card";
import { Button } from "@heroui/button";
import { ChevronLeft } from 'react-bootstrap-icons';
import {Spinner} from "@heroui/spinner";
import React, { RefObject } from "react";
import {InputOtp} from "@heroui/input-otp";

type checkPinCardProps = {
    refere: RefObject<HTMLInputElement>;
    refCode: string;
    backButton: () => void;
    goForward: () => void;
    usernameValue: string;
    setFullRefCode: (value: string) => void;
};

export default function CheckPinCard({
    refere,
    refCode,
    backButton,
    setFullRefCode,
    goForward,
    usernameValue,
}: checkPinCardProps) {

    const [pinInvalid, setPinInvalid] = React.useState("");
    const [pin, setPin] = React.useState("");
    const [waitClick, setWaitClick] = React.useState(false);

    const checkPinHandler = async () => {
        if (pin === "" || pin.length < 6) {
            setPinInvalid("กรุณากรอกรหัส OTP")
            refere.current?.focus()
            return
        }

        setWaitClick(true)

        const res = await fetch('/api/checkpin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                username: usernameValue,
                pin: pin,
                ref_code: refCode,
            }),
        })

        const data = await res.json()
        if (data.success) {
            setWaitClick(false)
            setFullRefCode(data.ref_code)
            goForward()
        } else {
            refere.current?.focus()
            setPinInvalid(data.msg)
            setWaitClick(false)
        }
    }

    return (
        <Card>
            <CardHeader className="text-center pb-0">
                <h1 className={logintitle()}>ยืนยันตัวตน</h1>
            </CardHeader>
            <CardBody className="overflow-hidden pt-0">
                <p className="text-sm text-gray-800 mb-6 text-center">กรุณากรอกรหัส OTP<br/>ที่ส่งไปยัง E-Mail ของคุณ</p>
                <InputOtp 
                    ref={refere} 
                    length={6} 
                    value={pin} 
                    errorMessage={pinInvalid} 
                    isInvalid={pinInvalid !== ""}
                    onValueChange={setPin}
                    onKeyDown={(e) => {
                        if (e.key === 'Enter') {
                            e.preventDefault()
                            checkPinHandler()
                        }
                    }}
                />
                <p className="text-sm text-gray-600 mb-6 text-center">Ref: {refCode}</p>
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
                        onPress={checkPinHandler}
                        disabled={waitClick}
                        className="justify-self-end"
                    >
                        {!waitClick ? (
                            "ตรวจสอบ"
                        ) : (
                            <Spinner color="primary" size="sm" />
                        )}
                    </Button>
                </div>
            </CardBody>
        </Card>
    )
}