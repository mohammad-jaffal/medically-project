

const DoctorData = ({ doctor_id, name, email, domain, balance }) => {



    return (
        <table className="data-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
                <th>Domain</th>
            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>{balance}</td>
                <td>{domain}</td>
            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>{balance}</td>
                <td>{domain}</td>
            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>{balance}</td>
                <td>{domain}</td>
            </tr>
        </table>
    );

}

export default DoctorData;