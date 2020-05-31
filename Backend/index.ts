import { Application, Router } from "https://deno.land/x/denotrain@v0.5.0/mod.ts";
import { quotes } from "./quotex.ts";



const app = new Application({hostname: "192.168.43.100"});

const router = new Router();

app.use("/api",router);


app.get("/",(ctx)=>{
    return "hello world";
});


router.get("/quotes",(ctx)=>{
    return {"quotes": quotes};
});


await app.run();