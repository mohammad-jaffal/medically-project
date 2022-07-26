

const UserData = ({ users, searchKey }) => {


    return (
        <table className="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Balance</th>
                </tr>
            </thead>
            {users.map((user, index) => {
                if (user.name.toLowerCase().includes(searchKey.toLowerCase()) || user.email.toLowerCase().includes(searchKey.toLowerCase())) {
                    return (
                        <tbody key={index}>
                            <tr >
                                <td>{user.id}</td>
                                <td>{user.name}</td>
                                <td>{user.email}</td>
                                <td>{user.balance}</td>
                            </tr>
                        </tbody>
                    )
                }
            })}

        </table>
    );

}

export default UserData;