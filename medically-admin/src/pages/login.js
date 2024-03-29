import { useNavigate } from "react-router-dom";
import { React, useEffect, useRef } from "react";
import * as myConstClass from '../consts/constants';

const Login = () => {
    const apiConst = myConstClass.api_const;
    let navigate = useNavigate();
    const emailRef = useRef(null);
    const passwordRef = useRef(null);
    const validateToken = () => {

        var token = localStorage.getItem('admin_token');
        // validate the token and check user type
        fetch(`${apiConst}/profile`, {
            method: "POST",
            headers: {
                "Authorization": 'Bearer ' + token,
                "Accept": 'application/json',
            },

        }).then(async res => {
            if (res.ok) {
                const data2 = await res.json();
                if (data2['type'] == 0) {
                    localStorage.setItem('admin_token', token);
                    navigate("/home", { replace: true });
                } else {
                    alert('You can\'t login here!');
                }
            }
        });
    }

    async function loginFunction() {
        var inputEmail = emailRef.current.value;
        var inputPass = passwordRef.current.value;
        if (inputEmail == "" || inputPass == "") {
            alert("fill all");
        } else {
            const params = new FormData();
            params.append('email', inputEmail);
            params.append('password', inputPass);
            // validate email and password

            await fetch(`${apiConst}/login`, {
                method: "POST",
                body: params,
            }).then(async res => {
                if (res.ok) {
                    const data = await res.json();
                    var token = data['access_token'];
                    // check user type
                    await fetch(`${apiConst}/profile`, {
                        method: "POST",
                        headers: {
                            "Authorization": 'Bearer ' + token,
                            "Accept": 'application/json',
                        },

                    }).then(async res => {
                        if (res.ok) {
                            const data2 = await res.json();
                            if (data2['type'] == 0) {
                                localStorage.setItem('admin_token', token);
                                navigate("/home", { replace: true });
                            } else {
                                alert('You can\'t login here!');
                            }
                        }
                    });
                }
                else {
                    alert("Wrong Credentials!")
                }
            })
        }

    }

    // use effect :)
    useEffect(() => {
        validateToken();
    }, [])

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