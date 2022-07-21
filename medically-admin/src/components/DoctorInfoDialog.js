import { React, useState, useEffect, useRef } from "react";


const DoctorInfoDialog = (props) => {
    const nameRef = useRef('');
    const tokenRef = useRef('');
    const domainRef = useRef('');

console.log(props.userId);
async function handleAdd(){
    if(nameRef.current.value == '' || tokenRef.current.value == ''){
        alert('fill all')
    }else
    {
        const params = new FormData();
        // change type to 2
        params.append('user_id', props.userId);
        fetch("http://localhost:8000/api/admin/accept-doctor", {
                method: "POST",
                body: params,
            }).then(async res => {
            if (res.ok) {
                const infoParams = new FormData();
                // adding doctor details
                infoParams.append('doctor_id', props.userId);
                infoParams.append('channel_name', nameRef.current.value);
                infoParams.append('channel_token', tokenRef.current.value);
                infoParams.append('domain_id', domainRef.current.value);

                fetch("http://localhost:8000/api/admin/add-doctor-details", {
                method: "POST",
                body: infoParams,
            }).then(async res=>{
                if (res.ok) {
                    await props.fetchPen();
                    props.closeDialog();
                }
            });
            }
        });
        
    }
}
    if (props.isOpen) {
        return (
            <div className="request-info-body">
                <div className="request-info-container">
                    <input type="text" ref={nameRef} className="domain-input" placeholder="Channel Name" required />
                    <input type="text" ref={tokenRef} className="domain-input" placeholder="Channel Token" required />
                    <select className="type-select" ref={domainRef}>
                    {props.domains.map((domain, index) => {
                                return (
                                    <option className="domain-filter-item" key={index} value={domain.id} onClick={() => {}}>{domain.domain_name}</option>
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