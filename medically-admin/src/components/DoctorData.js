

const DoctorData = ({ doctors, selectedDomain }) => {



    return (
        <table className="data-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
                <th>Domain</th>
            </tr>
            {doctors.map((doctor, index) => {
                if (doctor.domain_id == selectedDomain || selectedDomain==null) {
                    return (
                        <tr key={index}>
                            <td>{doctor.name}</td>
                            <td>{doctor.email}</td>
                            <td>{doctor.balance}</td>
                            <td>{doctor.domain_id}</td>
                        </tr>
                    );
                }
            })}
        </table>
    );

}

export default DoctorData;