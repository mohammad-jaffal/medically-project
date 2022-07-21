

const DoctorRequest = ({ doctor_id, name, email, domain, balance, accept, decline }) => {



    return (
        <table className="data-table">
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>
                    <button className="request-action-btn" onClick={decline}>decline</button>
                    <button className="request-action-btn" onClick={accept}>accept</button>
                </td>

            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>
                    <button className="request-action-btn" onClick={decline}>decline</button>
                    <button className="request-action-btn" onClick={accept}>accept</button>
                </td>

            </tr>
            <tr>
                <td>{name}</td>
                <td>{email}</td>
                <td>
                    <button className="request-action-btn" onClick={decline}>decline</button>
                    <button className="request-action-btn" onClick={accept}>accept</button>
                </td>

            </tr>
        </table>

    );

}

export default DoctorRequest;