import { logintitle } from "@/components/primitives";
import LoginLayout from "@/layouts/login";
import { Card, CardBody, CardHeader } from "@heroui/card";
import {Input} from "@heroui/input";
import { Button } from "@heroui/button";
import React from "react";
import { Eye, EyeSlash, ChevronRight, ChevronLeft } from 'react-bootstrap-icons';
import {Image} from "@heroui/image";
import {Spinner} from "@heroui/spinner";
import { motion, AnimatePresence } from "framer-motion";

import SendMailCard from "@/components/cards/sendMail";
import CheckPinCard from "@/components/cards/checkpin";
import NewPassCard from "@/components/cards/newpassword";
import FinishResetPassCard from "@/components/cards/finishResetPass";


export default function LoginPage() {
    React.useEffect(() => {
        usernameRef.current?.focus()
    }, [])

    const [step, setStep] = React.useState(1);
    const [direction, setDirection] = React.useState(1);

    const goForward = () => {
        if (step === 4)
            return
        setDirection(1);
        setStep(step + 1);
    };

    const goBack = () => {
        if (step === 1)
            return
        setDirection(-1);
        setStep(step - 1);
    };

    const variants = {
        enter: (dir: number) => ({ x: dir * 300, opacity: 0 }),
        center: { x: 0, opacity: 1 },
        exit: (dir: number) => ({ x: dir * -300, opacity: 0 }),
    };
    // ====================================

    const usernameRef = React.useRef<HTMLInputElement>(null)
    const [username, setUsername] = React.useState("");
    const [refCode, setRefCode] = React.useState("");
    // ====================================

    const PinRef = React.useRef<HTMLInputElement>(null)
    const [fullRefCode, setFullRefCode] = React.useState("");

    // ====================================

    const passRef = React.useRef<HTMLInputElement>(null)

    return (
        <LoginLayout>
            <div
                className="min-h-screen w-screen flex justify-center relative"
                style={{
                    backgroundImage: "url('/images/login_bg.jpg')",
                    backgroundSize: 'cover',
                    backgroundPosition: 'center',
                    backgroundRepeat: 'no-repeat',
                    backgroundAttachment: 'fixed',
                }}
            >
                <div className="absolute inset-0 bg-black/50 z-0" />

                <div className="relative z-10 mt-40">
                    <div className="flex justify-center mb-6">
                        <Image
                            src="/images/logo.png"
                            width={100}
                        />
                    </div>
                    <AnimatePresence mode="wait" custom={direction}>
                        {step === 1 && (
                            <motion.div
                                key="card1"
                                custom={direction}
                                initial="enter"
                                animate="center"
                                exit="exit"
                                variants={variants}
                                transition={{ duration: 0.2 }}
                                onAnimationComplete={() => {
                                    if (step === 1) {
                                        usernameRef.current?.focus();
                                    }
                                }}
                            >
                            <SendMailCard
                                refere={usernameRef}
                                usernameValue={username}
                                setUsernameValue={setUsername}
                                setRefCode={setRefCode}
                                goForward={goForward}
                            />
                            </motion.div>
                        )}
                        
                        {step === 2 && (
                            <motion.div
                                key="card2"
                                custom={direction}
                                initial="enter"
                                animate="center"
                                exit="exit"
                                variants={variants}
                                transition={{ duration: 0.2 }}
                                onAnimationComplete={() => {
                                    if (step === 2) {
                                        PinRef.current?.focus();
                                    }
                                }}
                            >
                            <CheckPinCard
                                refere={PinRef}
                                refCode={refCode}
                                backButton={goBack}
                                setFullRefCode={setFullRefCode}
                                goForward={goForward}
                                usernameValue={username}
                            />
                            </motion.div>
                        )}
                        {step === 3 && (
                            <motion.div
                                key="card2"
                                custom={direction}
                                initial="enter"
                                animate="center"
                                exit="exit"
                                variants={variants}
                                transition={{ duration: 0.2 }}
                                onAnimationComplete={() => {
                                    if (step === 3) {
                                        passRef.current?.focus();
                                    }
                                }}
                            >
                                <NewPassCard
                                    refere={passRef}
                                    fullRefCode={fullRefCode}
                                    usernameValue={username}
                                    backButton={goBack}
                                    goForward={goForward}
                                />
                            </motion.div>
                        )}
                        {step === 4 && (
                            <motion.div
                                key="card2"
                                custom={direction}
                                initial="enter"
                                animate="center"
                                exit="exit"
                                variants={variants}
                                transition={{ duration: 0.2 }}
                            >
                                <FinishResetPassCard/>
                            </motion.div>
                        )}
                    </AnimatePresence>
                </div>
            </div>
        </LoginLayout>
    );
}
