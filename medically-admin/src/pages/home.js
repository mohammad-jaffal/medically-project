import DoctorData from "../components/DoctorData";
import Navbar from "../components/NavBar";
import UserData from "../components/UserData";
import { React, useState, useEffect, useRef } from "react";
import { useNavigate } from "react-router-dom";
import * as myConstClass from '../consts/constants';



const Home = () => {
    const apiConst = myConstClass.api_const;
    var [selectedType, setSelectedType] = useState(1);
    const typeRef = useRef(null);
    const searchRef = useRef(null);
    var [searchKey, setSearchKey] = useState('');


    var [users, setUsers] = useState([]);
    var [doctors, setDoctors] = useState([]);
    var [domains, setDomains] = useState([]);
    var [selectedDomain, setSelectedDomain] = useState(null);
    var [filteredDoctors, setFilteredDoctors] = useState([]);


    let navigate = useNavigate();
    // validate token
    const validateToken = () =>{
        var token = localStorage.getItem('admin_token');
        fetch(`${apiConst}/profile`, {
                        method: "POST",
                        headers: {
                            "Authorization": 'Bearer ' + token,
                            "Accept": 'application/json',
                        },

                    }).then(async res => {
                        if (res.ok) {
                            const data = await res.json();
                            if (data['type'] != 0) {
                                localStorage.setItem('admin_token', "none");
                                navigate("/", { replace: true });
                            }
                        }else{
                            localStorage.setItem('admin_token', "none");
                                navigate("/", { replace: true });
                        }
                    });
    }

    // fetch all users
    const fetchUsers = async () => {
        await fetch(`${apiConst}/admin/get-users`, {
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
        await fetch(`${apiConst}/get-doctors`, {
            method: "GET",
        }).then(async res => {
            if (res.ok) {
                const data = await res.json();
                setDoctors(data['doctors']);
                setFilteredDoctors(data['doctors']);
            }
        });
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

    // use effect :)
    useEffect(() => {
        validateToken();
        fetchUsers();
        fetchDoctors();
        fetchDomains();
    }, [])


    return (
        <div className="global-container">
            <Navbar />
            <div className="home-body">
                <div className="filter-container" >
                    <select className="type-select" ref={typeRef} onChange={() => { setSelectedType(typeRef.current.value) }}>
                        <option value="1">Users</option>
                        <option value="2">Doctors</option>
                    </select>
                    {selectedType == 2 &&
                        <div className="domains-filter">
                            <div className="domain-filter-item" onClick={() => { setSelectedDomain(null) }}>All</div>
                            {domains.map((domain, index) => {
                                return (
                                    <div className="domain-filter-item" key={index} onClick={() => { setSelectedDomain(domain.id) }}>{domain.domain_name}</div>
                                )
                            })}

                        </div>
                    }

                </div>
                <div className="home-data-container">
                    <input type="text" ref={searchRef} className="search-input" placeholder="Name / Email" onChange={()=>{setSearchKey(searchRef.current.value)}}/>
                    {selectedType == 2 && <DoctorData doctors={filteredDoctors} domains={domains} selectedDomain={selectedDomain} searchKey={searchKey}/>}
                    {selectedType == 1 && <UserData users={users} searchKey={searchKey} />}

                </div>
            </div>
        </div>
    );
}

export default Home;