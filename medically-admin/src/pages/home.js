import DoctorData from "../components/DoctorData";
import Navbar from "../components/NavBar";
import UserData from "../components/UserData";
import { React, useState, useEffect, useRef } from "react";


const Home = () => {
    var [selectedType, setSelectedType] = useState(1);
    const typeRef = useRef(null);
    const searchRef = useRef(null);
    var [searchKey, setSearchKey] = useState('');


    var [users, setUsers] = useState([]);
    var [doctors, setDoctors] = useState([]);
    var [domains, setDomains] = useState([]);
    var [selectedDomain, setSelectedDomain] = useState(null);
    var [filteredDoctors, setFilteredDoctors] = useState([]);

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
                setFilteredDoctors(data['doctors']);
            }
        });
    }

    // fetch all domains
    const fetchDomains = async () => {
        await fetch("http://localhost:8000/api/get-domains", {
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