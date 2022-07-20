import { useNavigate } from "react-router-dom";

const Login = () => {
    let navigate = useNavigate();

    function loginFunction() {
        navigate("/home");
        // navigate("/home", { replace: true });
    }

    return (
        <div className="global-container">
            <div className="login-form-container">
                <p>Admin Login</p>
                <input type="text" id="li_email" className="login-input" placeholder="Email" required autoComplete="off" />
                <input type="password" id="li_password" className="login-input" placeholder="Password" required />
                <button className='login-btn' onClick={() => { loginFunction() }}>Login</button>
            </div>
        </div>
    );
}

export default Login;