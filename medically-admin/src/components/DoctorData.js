

const DoctorData = ({ doctors, selectedDomain, domains }) => {


    return (
        <table className="data-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
                <th>Domain</th>
            </tr>
            {doctors.map((doctor, index) => {
                if (doctor.domain_id == selectedDomain || selectedDomain == null) {
                    return (
                        <tr key={index}>
                            <td>{doctor.name}</td>
                            <td>{doctor.email}</td>
                            <td>{doctor.balance}</td>
                            {domains.map((domain, index) => {
                                if (domain['id'] == doctor.domain_id) {
                                    return <td key={index}>{domain['domain_name']}</td>;
                                }

                            })}
                        </tr>
                    );
                }
            })}
        </table>
    );

}

export default DoctorData;