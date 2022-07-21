import { useNavigate } from "react-router-dom";
import { React, useState, useEffect, useRef } from "react";
import axios from 'axios';

const Login = () => {
    let navigate = useNavigate();
    const emailRef = useRef(null);
    const passwordRef = useRef(null);

    async function loginFunction() {
        var inputEmail = emailRef.current.value;
        var inputPass = passwordRef.current.value;
        console.log(inputEmail);
        console.log(inputPass);
        if (inputEmail == "" || inputPass == "") {
            alert("fill all");
        } else {
            const params = new FormData();
            params.append('email', inputEmail);
            params.append('password', inputPass);
            // validate email and password
            // await axios.post(`http://localhost:8000/api/login`, params).then(async res => {

            //     if (res['status'] == 200) {
            //         var token = (res.data['access_token']);
            //         // check if admin login
            //         await axios.post("http://localhost:8000/profile", {
            //             headers: {
            //                 Authorization: 'Bearer ' + token,
            //                 Accept: 'application/json',
            //             },

            //         }).then(res => {

            //             console.log(res);
            //         })
            //     }

            // })
            //     .catch(err => {
            //         alert("login failed");
            //     })
            await fetch("http://localhost:8000/api/login", {
                method: "POST",
                body: params,
            }).then(async res=>{
                const data = await res.json();
                console.log(data);
            });
        }

        // navigate("/home", { replace: true });
    }

    return (
        <div className="global-container">
            <div className="login-form-container">
                <p>Admin Login</p>
                <input type="text" ref={emailRef} className="login-input" placeholder="Email" required autoComplete="off" />
                <input type="password" ref={passwordRef} className="login-input" placeholder="Password" required />
                <button className='login-btn' onClick={() => { loginFunction() }}>Login</button>
            </div>
        </div>
    );
}

export default Login;