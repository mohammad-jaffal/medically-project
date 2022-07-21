import { React, useState, useEffect, useRef } from "react";
import DoctorInfoDialog from "../components/DoctorInfoDialog";
import Navbar from "../components/NavBar";

const Requests = () => {

    var [isDialogOpen, setIsDialogOpen] = useState(false);

    var [pendingUsers, setPendingUsers] = useState([]);
    const domainRef = useRef('');

    // fetch all domains
    const fetchPending = async () => {
        await fetch("http://localhost:8000/api/admin/get-pending-users", {
            method: "GET",
        }).then(async res => {
            if (res.ok) {
                const data = await res.json();
                setPendingUsers(data['users']);
            }
        });
    }
    function acceptFuntion(id) {
        setIsDialogOpen(true);
        console.log(id);
    }
    async function rejectFuntion(id)  {
        const params = new FormData();
        params.append('user_id', id);
        await fetch("http://localhost:8000/api/admin/decline-doctor", {
                method: "POST",
                body: params,
            }).then(async res => {
            if (res.ok) {
                fetchPending();
            }
        });
    }
    function closeFunction() {
        setIsDialogOpen(false);
    }

    function addFunction() {
        console.log('adding');
    }

    useEffect(() => {
        fetchPending();
    }, [])


    return (
        <div className="global-container">
            <Navbar />
            <div className="requests-body">
                <p className="block-title">Requests:</p>

                <DoctorInfoDialog isOpen={isDialogOpen} closeDialog={closeFunction} addDoctor={addFunction} />
                <table className="data-table">
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Action</th>
                    </tr>
                    {pendingUsers.map((user, index) => {
                        return (
                            <tr key={index}>
                                <td>{user.name}</td>
                                <td>{user.email}</td>
                                <td>
                                    <button className="request-action-btn" onClick={() => {rejectFuntion(user.id) }}>decline</button>
                                    <button className="request-action-btn" onClick={()=>{acceptFuntion(user.id)}}>accept</button>
                                </td>
                            </tr>
                        )
                    })}
                    </table>
            </div>
        </div>
    );
}

export default Requests;