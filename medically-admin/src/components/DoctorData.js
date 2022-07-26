

const DoctorData = ({ doctors, selectedDomain, domains, searchKey }) => {


    return (
        <table className="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Balance</th>
                    <th>Rating</th>
                    <th>Domain</th>
                </tr>
            </thead>
            {doctors.map((doctor, index) => {
                if (doctor.domain_id == selectedDomain || selectedDomain == null) {
                    if (doctor.name.toLowerCase().includes(searchKey.toLowerCase()) || doctor.email.toLowerCase().includes(searchKey.toLowerCase())) {
                        return (
                            <tbody key={index}>
                                <tr>
                                    <td>{doctor.id}</td>
                                    <td>{doctor.name}</td>
                                    <td>{doctor.email}</td>
                                    <td>{doctor.balance}</td>
                                    <td>{doctor.rating}</td>
                                    {domains.map((domain, index) => {
                                        if (domain['id'] == doctor.domain_id) {
                                            return <td key={index}>{domain['domain_name']}</td>;
                                        }

                                    })}
                                </tr>
                            </tbody>
                        );
                    }
                }
            })}
        </table>
    );

}

export default DoctorData;