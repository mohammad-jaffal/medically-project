import { React, useState, useEffect, useRef } from "react";
import DoctorInfoDialog from "../components/DoctorInfoDialog";
import Navbar from "../components/NavBar";
import { useNavigate } from "react-router-dom";
import * as myConstClass from '../consts/constants';


const Requests = () => {

    var token = localStorage.getItem('admin_token');
    const apiConst = myConstClass.api_const;

    var [isDialogOpen, setIsDialogOpen] = useState(false);
    var [pendingUsers, setPendingUsers] = useState([]);

    var [domains, setDomains] = useState([]);
    var [userId, setUserId] = useState('');

    let navigate = useNavigate();


    // fetch all users with type 3
    const fetchPending = async () => {
        await fetch(`${apiConst}/admin/get-pending-users`, {
            method: "GET",
            headers: {
                "Authorization": 'Bearer ' + token,
                "Accept": 'application/json',
            },
        }).then(async res => {
            if (res.ok) {
                const data = await res.json();
                setPendingUsers(data['users']);
            } else {
                // redirect to login if error
                localStorage.setItem('admin_token', "none");
                navigate("/", { replace: true });
            }
        });
    }
    // opens the dialog to input doctors details
    async function acceptFuntion(id) {
        setUserId(id);
        setIsDialogOpen(true);

    }
    // sets the user type to 1 (normal user)
    async function rejectFuntion(id) {
        const params = new FormData();
        params.append('user_id', id);
        await fetch(`${apiConst}/admin/decline-doctor`, {
            method: "POST",
            body: params,
            headers: {
                "Authorization": 'Bearer ' + token,
                "Accept": 'application/json',
            },
        }).then(async res => {
            if (res.ok) {
                fetchPending();
            } else {
                // redirect to login if error
                localStorage.setItem('admin_token', "none");
                navigate("/", { replace: true });
            }
        });
    }
    // closes the dialog
    function closeFunction() {
        setIsDialogOpen(false);
    }
    // fetch all domains
    const fetchDomains = async () => {
        await fetch(`${apiConst}/get-domains`, {
            method: "GET",
        }).then(async res => {
            if (res.ok) {
                const data = await res.json();
                setDomains(data['domains']);
            }
        });
    }

    useEffect(() => {
        fetchPending();
        fetchDomains()
    }, [])


    return (
        <div className="global-container">
            <Navbar />
            <div className="requests-body">
                <p className="block-title">Requests:</p>

                <DoctorInfoDialog isOpen={isDialogOpen} closeDialog={closeFunction} userId={userId} domains={domains} fetchPen={fetchPending} />
                <table className="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    {pendingUsers.map((user, index) => {
                        return (
                            <tbody key={index}>
                                <tr>
                                    <td>{user.id}</td>
                                    <td>{user.name}</td>
                                    <td>{user.email}</td>
                                    <td>
                                        <button className="request-action-btn" onClick={() => { rejectFuntion(user.id) }}>decline</button>
                                        <button className="request-action-btn" onClick={() => { acceptFuntion(user.id) }}>accept</button>
                                    </td>
                                </tr>
                            </tbody>
                        )
                    })}
                </table>
            </div>
        </div>
    );
}

export default Requests;