import Navbar from "../components/NavBar";
import { React, useState, useEffect, useRef } from "react";


const AddDomain = () => {

    var [domains, setDomains] = useState([]);

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
        fetchDomains();
    }, [])

    return (
        <div className="global-container">
            <Navbar />
            <div className="add-domain-body">
                <p className="block-title">Add Domain:</p>
                <div className="domain-input-container">
                    <input type="text" className="domain-input" required />
                    <button className="admin-btn">Add</button>
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