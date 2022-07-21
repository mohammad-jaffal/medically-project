import { React, useState, useEffect, useRef } from "react";


const DoctorInfoDialog = (props) => {
    const nameRef = useRef('');
    const tokenRef = useRef('');

console.log(props.userId);
async function handleAdd(){
    if(nameRef.current.value == '' || tokenRef.current.value == ''){
        alert('fill all')
    }else
    {
        const params = new FormData();
        // change type to 2
        params.append('user_id', props.userId);
        await fetch("http://localhost:8000/api/admin/accept-doctor", {
                method: "POST",
                body: params,
            }).then(async res => {
            if (res.ok) {
                // fetchPending();
            }
        });
        props.closeDialog();
    }
    
}
    if (props.isOpen) {
        return (
            <div className="request-info-body">
                <div className="request-info-container">
                    <input type="text" ref={nameRef} className="domain-input" placeholder="Channel Name" required />
                    <input type="text" ref={tokenRef} className="domain-input" placeholder="Channel Token" required />
                    <select className="type-select">
                    {props.domains.map((domain, index) => {
                                return (
                                    <option className="domain-filter-item" key={index} onClick={() => {}}>{domain.domain_name}</option>
                                )
                            })}
                    </select>
                    <button className="admin-btn" onClick={()=>{handleAdd()}}>Add</button>
                    <button onClick={props.closeDialog}>Cancel</button>
                </div>
            </div>
        );
    }
    return <div />

}

export default DoctorInfoDialog;