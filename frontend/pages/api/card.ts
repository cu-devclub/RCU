import type { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {

    // Get the authToken from cookies
    const authToken = req.cookies?.authToken;
    
    if (!authToken) {
        res.status(401).json({ error: "Unauthorized" });
        return;
    }

    // Fetch the image from the backend API, passing the authToken as a cookie
    const responseI = await fetch(`${process.env.API_URL}/card`, {
        method: "GET",
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Cookie": `authToken=${authToken}`,
        },
    });

    console.log(responseI)

    if (!responseI.ok) {
        res.status(responseI.status).json({ error: "Failed to fetch image" });
        return;
    }

    // Set the response headers to match the image content type
    res.setHeader("Content-Type", responseI.headers.get("Content-Type") || "image/png");

    // Pipe the image data to the response
    const buffer = await responseI.arrayBuffer();
    res.send(Buffer.from(buffer));
}
