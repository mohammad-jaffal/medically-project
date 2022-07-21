import DoctorData from "../components/DoctorData";
import Navbar from "../components/NavBar";
import UserData from "../components/UserData";
import { React, useState, useEffect, useRef } from "react";


const Home = () => {
    var [selectedType, setSelectedType] = useState(1);
    const typeRef = useRef(null);

    var [users, setUsers] = useState([]);
    var [doctors, setDoctors] = useState([]);

    // fetch all users
    const fetchUsers = async () => {
        await fetch("http://localhost:8000/api/admin/get-users", {
                        method: "GET",
                    }).then(async res => {
                        if (res.ok) {
                            const data = await res.json();
                            setUsers(data['users']);
                        }
                    });
    }

    // fetch all doctors
    const fetchDoctors = async () => {
        await fetch("http://localhost:8000/api/get-doctors", {
                        method: "GET",
                    }).then(async res => {
                        if (res.ok) {
                            const data = await res.json();
                            setDoctors(data['doctors']);
                        }
                    });
    }

    // use effect :)
    useEffect(()=>{
        fetchUsers();
        fetchDoctors();
    },[])


    return (
        <div className="global-container">
            <Navbar />
            <div className="home-body">
                <div className="filter-container" >
                    <select className="type-select" ref={typeRef} onChange={() => {setSelectedType(typeRef.current.value)}}>
                        <option value="1">User</option>
                        <option value="2">Doctor</option>
                    </select>
                    {selectedType == 2 &&
                        <div className="domains-filter">
                            <div className="domain-filter-item">domain 1</div>
                            <div className="domain-filter-item">domain 2</div>
                            <div className="domain-filter-item">domain 3</div>
                            <div className="domain-filter-item">domain 4</div>
                            <div className="domain-filter-item">domain 5</div>
                        </div>
                    }

                </div>
                <div className="home-data-container">
                    <input type="text" className="search-input" placeholder="Name / Email" />
                    {selectedType == 2 && <DoctorData doctors={doctors} />}
                    {selectedType == 1 && <UserData users={users} />}

                </div>
            </div>
        </div>
    );
}

export default Home;