import Navbar from "../components/NavBar";
import { React, useState, useEffect, useRef } from "react";


const AddDomain = () => {

    var [domains, setDomains] = useState([]);
    const domainRef = useRef('');

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

    // Add domain
    const addDomainFunction = async () => {
        var domain_name = domainRef.current.value;
        if (domain_name == "") {
            alert("Enter name !")
        } else {
            const params = new FormData();
            params.append('domain_name', domain_name);
            await fetch("http://localhost:8000/api/admin/add-domain", {
                method: "POST",
                body: params,
            }).then(async res => {
                if (res.ok) {

                    const data = await res.json();
                    fetchDomains();
                }
            });
        }
    }



    // use effect :)
    useEffect(() => {
        fetchDomains();
    }, [])

    return (
        <div className="global-container">
            <Navbar />
            <div className="add-domain-body">
                <p className="block-title">Add Domain:</p>
                <div className="domain-input-container">
                    <input ref={domainRef} type="text" className="domain-input" required />
                    <button className="admin-btn" onClick={() => { addDomainFunction() }}>Add</button>
                </div>
                <p className="block-title">Available Domains:</p>
                <ul className="domains-container">
                    {domains.map((domain, index) => {
                        return (
                            <li key={index} className="domain-card"><span>{domain.domain_name}</span></li>
                        )
                    })}
                </ul>
            </div>
        </div>
    );
}

export default AddDomain;